module Yuuvis
  class Data < Base
    def get_all

    end

    def get_object(id)
      resp = connection.get do |req|
        req.url "/dms/objects/#{id}"
      end
      JSON.parse(resp.body)
    end

    def push_data(json = MOCK_JSON)
      data = Yuuvis::ToYuuvisMapper.new(json).convert
      body = data[:files].each_with_object({}) do |(key,val), body|
        body[key] = Faraday::UploadIO.new(val, 'text/plain')
      end.merge({
        data: Faraday::UploadIO.new(data[:metadata_path], 'application/json')
      })

      resp = multipart_connection.post do |req|
        req.url "/dms/objects"
        req.body = body
      end
      puts " ------- UPLOAD RESPONSE : #{JSON.parse(resp.body)} "

    end

    def bar_summary
      data = search("SELECT count(*) as count, version as version FROM reviewData GROUP BY version")
      first_res = data["objects"].each_with_object({}) do |item, obj|
        _dat = item['properties']
        obj[_dat.dig('version','value')] = {t_count: _dat.dig('count','value')}
      end

      first_res.each do |version, obj|
        obj[:distrib] = group_by_ratings(version)
      end
    end


    def group_by_ratings(version)
      data = search("SELECT count(*) as count, rating as rating FROM reviewData where version = '#{version}' GROUP BY rating;")
      data["objects"].each_with_object({}) do |item, obj|
        _dat = item['properties']
        obj[_dat.dig('rating','value')] = _dat.dig('count','value')
      end
    end

    def get_all_object_ids(skip_count: 0)
      data = search("SELECT objectId as id FROM enaio:object;", skip_count)
      data["objects"].each_with_object([]) do |item, obj_ids|

        obj_ids << item.dig('properties', 'id', 'value')
      end
    end

    def search(query, skip = 0)
      resp = connection.post do |req|
        req.url "/dms/objects/search"
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          query: {
            "statement": query,
            "skipCount": skip,
          }
        }.to_json
      end
      JSON.parse(resp.body)
    end
    def reset_threads!(skip_count: 0)
      get_all_object_ids(skip_count: skip_count).each do |id|
        Thread.start{delete!(id)}
      end
    end

    private

    def reset!(skip_count: 0)
      get_all_object_ids(skip_count: skip_count).each do |id|
        connection.delete do |req|
          req.url "/dms/objects/#{id}"
        end
      end
    end

    def delete!(id)
      connection.delete do |req|
        req.url "/dms/objects/#{id}"
      end
    end
  end
end

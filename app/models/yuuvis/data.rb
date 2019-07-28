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
      JSON.parse(resp.body)
    end

    def bar_summary
      resp = connection.post do |req|
        req.url "/dms/objects/search"
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          query: {
            "statement":"SELECT count(*) as count, version as version FROM enaio:object GROUP BY version"
          }
        }.to_json
      end
      data = JSON.parse(resp.body)
      first_res = data["objects"].each_with_object({}) do |item, obj|
        _dat = item['properties']
        obj[_dat.dig('version','value')] = {t_count: _dat.dig('count','value')}
      end

      first_res.each do |version, obj|
        obj[:distrib] = group_by_ratings(version)
      end
    end


    def group_by_ratings(version)
      resp = connection.post do |req|
        req.url "/dms/objects/search"
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          query: {
            "statement":"SELECT count(*) as count, rating as rating FROM enaio:object where version = '#{version}' GROUP BY rating;"
          }
        }.to_json
      end
      data = JSON.parse(resp.body)
      data["objects"].each_with_object({}) do |item, obj|
        _dat = item['properties']
        obj[_dat.dig('rating','value')] = _dat.dig('count','value')
      end
    end

  end
end

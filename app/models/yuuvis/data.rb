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

    def chart_x
      data = search("SELECT sentiment as sentiment, created as created FROM reviewData where
          created > '2019-07-20T21:42:18.000Z'
          and created < '2019-07-28T21:42:18.000Z'
          order by created asc",0, 500)
      positives = Hash.new{|h,k| h[k] = 0}
      negatives = Hash.new{|h,k| h[k] = 0}
      data['objects'].each do |item, |
        _dat = item['properties']
        date = _dat.dig('created','value').to_datetime.day
        val = _dat.dig('sentiment','value')
        if val > 0
          positives[date] +=1
        else
          negatives[date] +=1
        end
      end
      {
        positives: positives,
        negatives: negatives
      }
    end


    def chart_1(data = nil)
      data = search("SELECT sentiment as sentiment, version as version FROM reviewData order by version",0, 2000) unless data
      positives = Hash.new{|h,k| h[k] = 0}
      negatives = Hash.new{|h,k| h[k] = 0}
      data['objects'].each do |item, |
        _dat = item['properties']
        version = _dat.dig('version','value')
        val = _dat.dig('sentiment','value')
        if val > 0
          positives[version] +=1
        else
          negatives[version] +=1
        end
      end
      {
        positives: positives,
        negatives: negatives
      }
    end

    def get_all_object_ids(skip_count: 0)
      data = search("SELECT objectId as id FROM reviewData;", skip_count)
      data["objects"].each_with_object([]) do |item, obj_ids|

        obj_ids << item.dig('properties', 'id', 'value')
      end
    end

    def dashboard_charts
      data = get_all
      positives = Hash.new{|h,k| h[k] = 0}
      negatives = Hash.new{|h,k| h[k] = 0}
      ratings_hash = Hash.new{|h,k| h[k] = 0}
      tags = Hash.new{|h,k| h[k] = {count:0, sentiment:0}}
      data['objects'].each do |item |
        _dat = item['properties']
        next if _dat.empty?
        rating = _dat.dig('rating','value')
        version = _dat.dig('version','value')
        val = _dat.dig('sentiment','value')
        tag_hash = _dat.dig('tags','value').zip(_dat.dig('tagsSentiment','value')).to_h
        tag_hash.each do |key,val|
          _tmp = tags[key.downcase]
          tags[key.downcase] = {count: _tmp[:count]+1, sentiment: _tmp[:sentiment]+val }
        end
        if val > 0
          positives[version] +=1
        else
          negatives[version] +=1
        end
        ratings_hash[rating.round] +=1
      end
      {
        chart2: {
          positives: positives,
          negatives: negatives
        },
        chart1: {
          data: ratings_hash.sort
        },
        entries: tags.sort_by{|_k,v| v[:sentiment].abs}.reject{|item| item.first.length < 3}.reverse[0..22].map(&:first)
      }
    end

    def get_all
      search("SELECT rating as rating, sentiment as sentiment, created as created,
        tags as tags, version as version, tagsSentiment as tagsSentiment FROM reviewData order by created desc;", 0,2000)
    end


    def search(query, skip = 0, max = 50)
      resp = connection.post do |req|
        req.url "/dms/objects/search"
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          query: {
            "statement": query,
            "skipCount": skip,
            "maxItems": max
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

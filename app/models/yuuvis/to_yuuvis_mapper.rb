module Yuuvis
  class ToYuuvisMapper
    attr_accessor :data, :files, :objects
    def initialize(data)
      @data = data
      @objects = []
      @files = {}
    end

    def convert
      data.each_with_index do |datum, index|
        build_files(datum, index)
      end

      {
        metadata_path: create_meta_file,
        files: @files
      }
    end

    def create_meta_file
      filename = Rails.root.join("public/metadata.json")
      content_streams = @files.each_with_object([]){|(k,_v), obj| obj.push({cid: k})}
      _meta = {
        objects: @objects,
        contentStreams: content_streams
      }
      File.open(filename,"w") do |f|
        f.write(_meta.to_json)
      end
      filename.to_path
    end

    def build_files(data, index)
      file_name = build_review_file(data[:text], index)
      metadata = build_metadata(data, index)
      @objects.push(metadata)
      @files[metadata[:contentStreams].first[:cid]] = file_name
    end

    def build_review_file(review, index)
      param_name = "review_#{Time.now.to_i}_#{index}"
      filename = Rails.root.join("public/reviews/#{param_name}.txt")
      File.open(filename,"w") do |f|
        f.write(review)
      end
      filename.to_path
    end

    def build_metadata(data, index)
      _data = %I( version created author).each_with_object({}) do |key, hash|
        hash[key] = { value: data[key]}
      end

      _data = %I(rating sentiment votes).each_with_object(_data) do |key, hash|
        hash[key] = { value: data[key].to_f}
      end
      {
        properties: _data.merge({
            'enaio:objectTypeId' => {
              value: "review"
            },
            tags: {
              value: data[:tags].keys
            },
            tagsSentiment: {
              value: data[:tags].values.map(&:to_f)
            }
        }),
        contentStreams: [
          {
            cid: "review_#{Time.now.to_i}_index"
          }
        ]
      }
    end
  end
end
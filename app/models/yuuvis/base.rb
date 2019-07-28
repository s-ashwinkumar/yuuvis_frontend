module Yuuvis
  class Base
    AUTH_TOKEN_1 = 'e2e7f52d937a4f67b58e63bd93f70a3d'.freeze
    AUTH_TOKEN_2 = 'f12365ba70db4f4aaae5e5bc94ffb3aa'.freeze
    HOST = 'https://api.yuuvis.io'.freeze
    MOCK_JSON = [
      {
        rating: 3.5,
        version: '1.22.11',
        votes: 3,
        created:  "2019-02-02T06:04:27-07:00",
        author: "John Wick",
        sentiment: 0.2,
        tags: {
          'app' => 0.4,
          'location detection' => 0.2,
          'download' => -0.1,
          'login' => -0.4,
        },
        text: 'Not Mobile Device Edit Friendly The app is not beginner user-friendly and there is no introduction on how to use the app when you first download and join.All major edits (e.g. deleting a channel or workspace) can only be done on a desktop. If set up can be done on a mobile device, all editing should possible on a mobile device as well, especially when there is no introduction on how to use the app. I liked the location detection and would love to see it evolve.'
      },
      {
        rating: 4.5,
        version: '1.23.6',
        votes: 1,
        created:  "2019-02-03T06:04:27-07:00",
        author: "Baba Yaga",
        sentiment: 0.2,
        tags: {
          'app' => 0.4,
          'location detection' => 0.2,
        },
        text: 'Good Software I have no problem with it other than some notification problems that sometimes happen and or call drop outs that happen when performing audio calls they need to work on that but other than that as a messaging application it is great for business'
      }
    ]

    def connection
      @connection_non ||= Faraday.new(:url => HOST) do |faraday|
        faraday.headers['Ocp-Apim-Subscription-Key'] =   AUTH_TOKEN_1
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def multipart_connection
      @connection_mul ||= Faraday.new(:url => HOST) do |faraday|
        faraday.headers['Ocp-Apim-Subscription-Key'] =   AUTH_TOKEN_1
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

  end
end
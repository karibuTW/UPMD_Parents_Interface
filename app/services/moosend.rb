class Moosend
  require 'net/http'
  require 'uri'
  require 'json'
  BASE_URL = "https://api.moosend.com/v3"

  MAILING_LIST_ID = Rails.application.credentials.dig(:moosend_mailing_list_id)
  
  API_KEY = Rails.application.credentials.dig(:moosend_api_key)

  def self.get_mailing_list_by_id(mailing_list_id)
    uri = URI.parse("#{BASE_URL}" + "/lists/" + mailing_list_id + "/details.json?apikey=#{API_KEY}" )  
    request = Net::HTTP::Get.new(uri)
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    p JSON.parse(response.body)
  end

  def self.add_email_to_mailing_list(body)
    uri = URI.parse(BASE_URL + "/subscribers/#{MAILING_LIST_ID}/subscribe.json?apikey=#{API_KEY}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri ,{'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
    request.body = body.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.update_mail_in_mailing_list(subscriber_id , body)
    uri = URI.parse(BASE_URL + "/subscribers/#{MAILING_LIST_ID}/update/#{subscriber_id}.json?apikey=#{API_KEY}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri ,{'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.delete_mail_in_mailing_list(subscriber_id,body)
    uri = URI.parse(BASE_URL + "/subscribers/#{MAILING_LIST_ID}/unsubscribe.json?apikey=#{API_KEY}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri ,{'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.create_custom_field(name, custom_field_type)
    uri = URI.parse(BASE_URL + "/lists/#{MAILING_LIST_ID}/customfields/create.json?apikey=#{API_KEY}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri ,{'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
    body = {
      Name: name,
      CustomFieldType: custom_field_type
    }
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.create_all_custom_fields_related_to_parents
    all_fields = [ "Registration_Date","Last_Update","firstname","lastname","fullname","parent_type","Preferred_Language","Phone_number","Address","Mailing_List",
      "Nationalities","Paid", "HelloAsso_ID","PaymentDate","PaymentMethod","Donated","CodeUsed","OrderConfirmation","Bus","1st-Child-Full_name",
      "1st-Child-Birth_date","1st-Child-Age","1st-Child-Grade","2nd-Child-Full_name","2nd-Child-Birth_date","2nd-Child-Age","2nd-Child-Grade",
      "3rd-Child-Full_name","3rd-Child-Birth_date","3rd-Child-Age",
      "3rd-Child-Grade", "4th-Child-Full_name" , "4th-Child-Birth_date", "4th-Child-Age", "4th-Child-Grade", "5th-Child-Full_name",
      "5th-Child-Birth_date", "5th-Child-Age", "5th-Child-Grade","NumberOfChildren"
    ]
    all_fields.each do |field|
      p field
      if field == "Mailing_List"
        type = 'Checkbox'
      else
        type = 'Text'
      end
      p create_custom_field(field, type)
    end
  end
end
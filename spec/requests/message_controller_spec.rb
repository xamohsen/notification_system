require 'rails_helper'

RSpec.describe MessageController, type: :request do
  describe "Post /application/" do
    context 'when the request is valid and en local' do
      before :all do
        post "/message/", params: {message: {title: 'title#en', body: "body#en", icon: 'icon'}}
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
      it 'returns message after creation' do
        expect(json['title']).to eq('title#en')
        expect(json['body']).to eq('body#en')
        expect(json['icon']).to eq('icon')
        expect(json['link_to']).to eq(nil)
      end

      it 'should return title nil with local:ar' do
        I18n.locale = 'ar'
        message = Message.first
        expect(message['title']).to eq(nil)
      end

      it 'should return title "title" with local:en' do
        I18n.locale = 'en'
        message = Message.first
        expect(message['title']).to eq('title#en')
      end

      after :all do
        Message.delete_all
      end
    end

    context 'when the request is valid and ar local' do
      before :all do
        post "/message/", params: {message: {title: 'عنوان', body: "محتوي", icon: 'icon'}, local: 'ar'}
      end
      it 'should create message with ar local -> en title = nil' do
        I18n.locale = 'en'
        message = Message.first
        expect(message['title']).to eq(nil)
      end
      it 'should create message with ar local -> ar title = عنوان' do
        I18n.locale = 'ar'
        message = Message.first
        expect(message['title']).to eq('عنوان')
      end
      after :all do
        Message.delete_all
      end
    end

    context 'when the request is invalid' do
      it 'returns status code 422#1' do
        post "/message/", params: {message: {body: "body#en", icon: 'icon'}, local: 'en'}
        expect(response.message).to eq('Unprocessable Entity')
      end
      it 'returns message Unprocessable Entity' do
        post "/message/", params: {message: {body: "body#en", icon: 'icon'}, local: 'en'}
        expect(response.message).to eq('Unprocessable Entity')
      end
      it 'returns status code 422#2' do
        post "/message/", params: {}
        expect(response.message).to eq('Unprocessable Entity')
      end
      it 'returns status code 422#3' do
        post "/message/", params: {message: {}}
        expect(response.message).to eq('Unprocessable Entity')
      end
      after :each do
        Message.delete_all
      end
    end
  end

  describe "get /message/:id" do
    let!(:message) {create :message}
    it 'returns status code 200' do
      get "/message/#{message["id"]}"
      expect(response).to have_http_status(200)
    end
    it 'returns status code 404' do
      get "/message/#{message["id"] + 10}"
      expect(response).to have_http_status(404)
    end
    it 'returns message content' do
      get "/message/#{message["id"]}"
      expect(json['title']).to eq message['title']
      expect(json['body']).to eq message['body']
      expect(json['icon']).to eq message['icon']
    end
    it 'returns nil message content for ar local' do
      get "/message/#{message["id"]}/#{'ar'}"
      expect(json['title']).to eq nil
      expect(json['body']).to eq nil
    end
    after :each do
      Message.delete_all
    end
  end
  describe "get /messages/" do
    let!(:messages) {create_list :message, 100}
    it 'returns status code 200' do
      get "/messages/"
      expect(response).to have_http_status(200)
    end
    it 'returns count' do
      get "/messages/"
      expect(json.length).to eq(100)
    end
    after :all do
      Message.delete_all
    end
  end
  describe "Put /application/" do
    let!(:message) {create :message}
    context 'when the request is valid and en local' do
      it 'returns status code 200' do
        put "/message/", params: {message: {id: message['id'], title: 'title#en', body: "body#en", icon: 'icon'}}
        expect(response).to have_http_status(200)
      end
      it 'should add ar content' do
        put "/message/", params: {message: {id: message['id'], title: 'arabic', body: "arabic", icon: 'icon'}, local: 'ar'}
        expect(response).to have_http_status(200)
        I18n.locale = :en
        en_message = Message.last
        expect(en_message['title']).to eq message['title']

        I18n.locale = :ar
        ar_message = Message.last
        expect(ar_message['title']).to eq 'arabic'
      end
      after :all do
        Message.delete_all
      end
    end
  end
end

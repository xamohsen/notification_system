require 'rails_helper'

RSpec.describe NotificationController, type: :request do
  describe "Post /notification/" do

    context 'when the request is valid' do
      before :all do
        @user = create :user
        @message = create :message
        post "/notification/", params: {user_id: @user[:id],
                                        message_id: @message[:id],
                                        notification_type: 'sms'}
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
      it 'should have one notification' do
        expect(Notification.count).to eql(1)
      end
      it 'returns message after creation' do
        expect(json['user_id']).to eq(@user[:id])
        expect(json['message_id']).to eq(@message[:id])
        expect(json['notification_type']).to eq('sms')
        expect(json['status']).to eq(0)
      end
      after :all do
        Notification.delete_all
        Message.delete_all
        User.delete_all
      end
    end

    context 'when the request is invalid #user nil' do
      before :all do
        @user = create :user
        @message = create :message
        post "/notification/", params: {message_id: @message[:id],
                                        notification_type: 'sms'}
      end
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'should have zero notification' do
        expect(Notification.count).to eql(0)
      end
    end

    context 'when the request is invalid #message nil' do
      before :all do
        @user = create :user
        @message = create :message
        post "/notification/", params: {user_id: @user[:id],
                                        notification_type: 'sms'}
      end
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'should have zero notification' do
        expect(Notification.count).to eql(0)
      end
    end
  end

  describe "Post /notification_group/" do

    context 'when the request is valid' do
      before :all do
        @users = create_list :user, 10
        @message = create :message
        post "/notification_group/", params: {users: @users.to_json,
                                        message_id: @message[:id],
                                        notification_type: 'sms'}
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(201)
      end
      it 'should have one notification' do
        expect(Notification.count).to eql(10)
      end
      it 'returns message after creation' do
        expect(json.first['user_id']).to eq(@users[0][:id])
        expect(json.first['message_id']).to eq(@message[:id])
        expect(json.first['notification_type']).to eq('sms')
        expect(json.first['status']).to eq(0)
      end
      after :all do
        Notification.delete_all
        Message.delete_all
        User.delete_all
      end
    end

    # context 'when the request is invalid #user nil' do
    #   before :all do
    #     @user = create :user
    #     @message = create :message
    #     post "/notification/", params: {message_id: @message[:id],
    #                                     notification_type: 'sms'}
    #   end
    #   it 'returns status code 404' do
    #     expect(response).to have_http_status(404)
    #   end
    #   it 'should have zero notification' do
    #     expect(Notification.count).to eql(0)
    #   end
    # end
    #
    # context 'when the request is invalid #message nil' do
    #   before :all do
    #     @user = create :user
    #     @message = create :message
    #     post "/notification/", params: {user_id: @user[:id],
    #                                     notification_type: 'sms'}
    #   end
    #   it 'returns status code 404' do
    #     expect(response).to have_http_status(404)
    #   end
    #   it 'should have zero notification' do
    #     expect(Notification.count).to eql(0)
    #   end
    # end
  end
end

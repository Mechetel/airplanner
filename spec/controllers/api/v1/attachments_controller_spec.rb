require 'rails_helper'

RSpec.describe Api::V1::AttachmentsController, type: :controller do
  sign_in_user

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'uploads the file' do
        expect do
          post :create, params: attributes_for(:attachment)
        end.to change(Attachment, :count).by(0)
      end
    end

    context 'with invalid attributes' do
      it 'does not upload the file' do
        expect do
          post :create, params: attributes_for(:invalid_attachment)
        end.to_not change(Attachment, :count)
      end
    end
  end
end

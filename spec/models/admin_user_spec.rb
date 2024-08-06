# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'Devise modules' do
    it 'includes database_authenticatable' do
      expect(AdminUser.devise_modules).to include(:database_authenticatable)
    end

    it 'includes recoverable' do
      expect(AdminUser.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(AdminUser.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(AdminUser.devise_modules).to include(:validatable)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(AdminUser.ransackable_attributes).to match_array(%w[created_at email encrypted_password id id_value
                                                                 remember_created_at reset_password_sent_at
                                                                 reset_password_token updated_at])
    end
  end
end

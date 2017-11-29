require 'spec_helper'

RSpec.describe Admin::Authenticator do
  describe "#authentidate" do
    example '正しいパスワードならtrueを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'パスワード未設定ならfalseを返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsy
    end
  end
end

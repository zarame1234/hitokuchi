require 'rails _helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user)}
  context 'バリテーションの確認' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end

    it '住所が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new
  end
end

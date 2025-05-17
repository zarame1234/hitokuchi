require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user)}
  
  context 'バリテーションの確認' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end

    it '住所が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = FactoryBot.build(:post, address: nil)
      expect(post).to be_invalid
      expect(post.errors[:address]).to include("を入力してください")
    end

    it 'コメントが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = FactoryBot.build(:post, body: nil)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("を入力してください")
    end

    it 'コメントが51文字以上の場合にエラーメッセージが返る' do
      post = FactoryBot.build(:post, body: 'あ' * 51)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("は50文字以内で入力してください")
    end
  end
end

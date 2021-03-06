require 'rails_helper'

describe Product do
    context "when the product has comments" do

        before do
            @user = FactoryBot.create(:user)
            @product = FactoryBot.create(:product)
            @c1 = FactoryBot.create(:comment, rating: 5, product: @product)
            @c2 = FactoryBot.create(:comment, rating: 3, product: @product)
            @c3 = FactoryBot.create(:comment, rating: 1, product: @product)
        end

        it "returns the average rating of all comments" do
            expect(@product.average_rating).to eq 3
        end

        it "returns the highest rating comment of all comments" do
            expect(@product.highest_rating_comment).to eq @c1
        end

        it "returns the lowest rating comment of all comments" do
            expect(@product.lowest_rating_comment).to eq @c3
        end
    end

    context "When the product is created" do

        it "product is invalid without a name" do
            expect(FactoryBot.build(:product, name: nil)).not_to be_valid
        end

        it "product is invalid without a description" do
            expect(FactoryBot.build(:product, description: nil)).not_to be_valid
        end

        it "product is invalid without a price" do
            expect(FactoryBot.build(:product, price: nil)).not_to be_valid
        end

        it "sets a default image url if the text field in the form is empty" do
            expect(FactoryBot.build(:product, image_url: nil)).to be_valid
        end
    end

    context "When the model has a price in cents saved" do
        before do
            @product = FactoryBot.create(:product)
        end

        it "converted price method returns the price in proper format" do
            expect(@product.converted_price).to eq @product.price * 0.01
        end
        
    end
end

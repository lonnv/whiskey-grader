require 'rails_helper'

RSpec.describe ReviewForm do
    let(:review_form) do
        ReviewForm.new(
            title: 'A title',
            description: 'A description',
            taste_grade: 5,
            color_grade: 4,
            smokiness_grade: 2
        )
    end

    describe 'validations' do
        it "is valid with valid attributes" do
            expect(review_form).to be_valid
        end
        
        it "is not valid without a title" do
            review_form.title = nil
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:title)
        end

        it "is not valid without a description" do
            review_form.description = nil
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:description)
        end

        it "is not valid without a taste_grade" do
            review_form.taste_grade = nil
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:taste_grade)
        end

        it "is not valid without a color_grade" do
            review_form.color_grade = nil
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:color_grade)
        end

        it "is not valid without a smokiness_grade" do
            review_form.smokiness_grade = nil
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:smokiness_grade)
        end

        it "is not valid with a taste grade smaller than 1" do
            review_form.taste_grade = 0
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:taste_grade)
        end

        it "is not valid with a taste grade greather than 5" do
            review_form.taste_grade = 6
            expect(review_form).not_to be_valid
            expect(review_form.errors).to have_key(:taste_grade)
        end
    end

    describe 'submit' do
        subject { review_form.submit }

        context 'on a valid form' do
            it 'returns true' do
                expect(subject).to be_truthy
            end

            it 'calculates and sets the average_grade' do
                expect{ subject }
                .to change{ review_form.average_grade }
                .from(nil).to(3.0)
            end

            it 'creates a new review' do
                expect{ subject }
                .to change{ Review.count }
                .from(0).to(1)
            end
        end

        context 'on a invalid form' do
            let(:review_form) { ReviewForm.new }
            
            it 'returns false' do
                expect(subject).to be_falsey
            end

            it 'does not create a new review' do
                expect{ subject }
                .not_to change{ Review.count }
            end
            
        end

    end
end
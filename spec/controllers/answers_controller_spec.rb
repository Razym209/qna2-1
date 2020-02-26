require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #edit' do
    sign_in_user
    before do
      get :edit, params: {id: answer}
    end

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question, format: :js} }.to change(question.answers, :count).by(1)
      end

      it 'answer associates with current user' do
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question, format: :js} }.to change(@user.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: {answer: attributes_for(:invalid_answer), question_id: question, format: :js} }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    context 'valid attributes' do
      it 'assings the requested answer to @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer.id, answer: { body: 'new body'} }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to the updated answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer.question
      end
    end

    context 'invalid attributes' do
      before do
        patch :update, params: { id: answer, answer: { body: nil} }
      end

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq answer.body
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer) { create(:answer, question: question, author: @user) }

    context 'Author deletes his answer' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer} }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'Non Author delete him answer' do
      let(:user2) { create(:user) }
      let!(:answer2) { create(:answer, question: question, author: user2) }

      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer2 } }.to_not change(Answer, :count)
      end

      it 'redirect to question view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end

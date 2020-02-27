  before { login(another_user) }
      it 'tries to delete the question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
      it 'redirects to list of questions' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
    context 'Unauthorized user' do
      it 'tries to delete the question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
      it 'redirects to login page' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title for question', body: 'new body for question' } }, format: :js
        question.reload

        expect(question.title).to eq 'new title for question'
        expect(question.body).to eq 'new body for question'
      end

      it 'renders update view' do
        patch :update, params: { id: question, question: { title: 'new title for question', body: 'new body for question' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      before { login(user) }
      it 'does not change question attributes' do
          patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
          expect(assigns(:question)).to eq question
      end

      it 'renders update view' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'Not an author' do
      let(:another_user) { create(:user) }
      before { login(another_user) }

      it 'tries to edit the question' do
        patch :update, params: { id: question, question: { title: 'new title for question', body: 'new body for question' } }, format: :js
        question.reload

        expect(question.title).to_not eq 'new title for question'
        expect(question.body).to_not eq 'new body for question'
      end
    end

    context 'Unauthorized user' do
      it 'tries to edit the question' do
        patch :update, params: { id: question, question: { title: 'new title for question', body: 'new body for question' } }, format: :js
        question.reload

        expect(question.title).to_not eq 'new title for question'
        expect(question.body).to_not eq 'new body for question'
      end
    end
  end
end

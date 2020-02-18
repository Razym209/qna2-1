class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: %w[edit update destroy]
  before_action :load_question, only: %w[create]

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)

    @answer.author_id = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      render "questions/show"
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'you successfully deleted'
    else
      flash[:notice] = 'you do not have enough rights'
    end
    redirect_to question_path(@answer.question)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end

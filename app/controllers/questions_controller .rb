class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  before_action :load_question, only: %w[new_answer show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answer.links.new
  end

  def new
    @question = Question.new
    @question.links.new
    @question.reward = Reward.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    reward = @question.reward.present? ? ' Reward was set.' : ''
    if @question.save
      redirect_to @question, notice: "Your question successfully created.#{reward}"
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
   @question.destroy if current_user&.author_of?(@question)
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body,
                                      files: [], links_attributes: [:name, :url, :_destroy],
                                      reward_attributes: [:name, :picture])
  end
end

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    return guest_abilities unless user
    user.admin? ? admin_abilities : user_abilities
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer], user_id: user
    can :destroy, [Question, Answer], user_id: user

    can [:upvote, :cancel_vote, :downvote], Votable do |votable|
      !user.author_of?(votable)
    end
   
        alias_action :vote_up, :vote_down, to: :vote

    can :vote, [Question, Answer] do |resource|
      user.not_author_of?(resource)
    end
    
    
    
    
    
    
    
    can :select_best, Answer do |answer|
      user.author_of?(answer.question) && !answer.best
    end

    can :destroy, Link do |link|
      user.author_of?(link.linkable)
    end

    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end
  end
end

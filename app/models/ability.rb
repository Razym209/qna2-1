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
    can :update, [Question, Answer], user_id: user.id
    can :destroy, [Question, Answer], user_id: user.id

    can [:upvote, :cancel_vote, :downvote], Votable do |votable|
      !user.author_of?(votable)
    end
 
    can :select_best, Answer do |answer|
      user.author_of?(answer.question) && !answer.best
    end

    can :destroy, Link do |link|
      user.author_of?(link.linkable)
    end
        
      can :destroy, ActiveStorage::Attachment, record: { user_id: user.id }
  end
end

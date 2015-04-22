class Ability

  include Hydra::Ability
  include Worthwhile::Ability
  self.ability_logic += [:everyone_can_create_curation_concerns]

 # Taken from https://github.com/KelvinSmithLibrary/absolute/blob/master/app/models/ability.rb

  # Define any customized permissions here.
  def custom_permissions
    admin_permissions if current_user.admin?
  end

  # Abilities that should only be granted to admin users
  def admin_permissions
    scanned_book_creator_permissions
    can [:create, :show, :add_user, :remove_user, :index], Role
    can [:read, :edit, :update, :destroy, :publish], curation_concerns
    can :create, curation_concerns
    can :create, Collection
    can [:destroy], ActiveFedora::Base
    can :manage, Resque
    can :manage, :bulk_update
  end

    # Abilities that should be granted to technician users
  def scanned_book_creator_permissions
    campus_patron_permissions

    # can [:read, :read_private_collection], Collection
    #can [:read, :create], Hydra::Admin::Collection
    # can :create, Collection
    can [:read, :edit, :update, :destroy, :publish], curation_concerns
    can :create, curation_concerns
  end

  # Abilities that should be granted to patron
  def campus_patron_permissions

    # Should ne able to read access rights "Princeton Only"
    #can [:read, :read_private_collection], Collection
    can :read, curation_concerns
  end

  private

  def curation_concerns
    Worthwhile.configuration.curation_concerns
  end
end
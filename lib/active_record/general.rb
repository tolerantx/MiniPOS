module ActiveRecord
  module General
    def self.included(base)
      base.class_eval do
        scope :by_account, -> (user) {
          where(account_id: user.account.id) if user.admin?
        }

        extend ClassMethods
      end
    end

    module ClassMethods
      def find_record(id, account)
        find_by_id_and_account_id(id, account.id)
      end
    end
  end
end
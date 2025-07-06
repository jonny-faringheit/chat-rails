module Extensions
  module FindAllConversationsWithUserExtension
    def with_user(other_user)
      joins(:conversation_participants)
        .where(conversation_participants: { user_id: other_user.id })
        .group('conversations.id')
        .having('COUNT(conversation_participants.id) = 2')
    end
  end
end

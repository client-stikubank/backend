class TransactionSerializer
  include JSONAPI::Serializer

  attributes :sourceable, :transactable, :subject
end

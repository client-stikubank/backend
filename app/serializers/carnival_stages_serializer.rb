class CarnivalStagesSerializer
  include JSONAPI::Serializer

  attributes :name, :level

  attribute :high_amount do |object|
    object.camps.map{ |c| c.reward_amount.join('') }.max
  end
end

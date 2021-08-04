class GamesSerializer < Blueprinter::Base
  identifier :id

  fields :status, :score, :created_at, :updated_at

  association :frames, blueprint: FramesSerializer
end

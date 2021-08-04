class FramesSerializer < Blueprinter::Base
  identifier :number

  fields :first_delivery, :second_delivery, :third_delivery, :score,
         :kind, :status, :created_at, :updated_at
end

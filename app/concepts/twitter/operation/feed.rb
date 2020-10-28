class Twitter::Operation::Feed < Trailblazer::Operation
  step :authorize, Output(:failure) => End(:not_authorized)
  step :model, Output(:failure) => End(:not_found)
  step :load_json

  def authorize(ctx, **)
    true
  end

  def model(ctx, **)
    ctx[:model] = {
      "created_at": "Tue Feb 27 21:11:40 +0000 2018",
    }
  end

  def load_json(ctx, **)
    true
  end
end
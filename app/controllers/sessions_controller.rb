class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:verify]

  def nonce
    render plain: Siwe::Util.generate_nonce
  end

  def verify
    params.permit!
    message_json_string = params[:message].to_h.transform_keys(&:underscore).to_json
    p message_json_string
    message = Siwe::Message.from_json_string(message_json_string)
    signature = params[:signature]
    p signature

    if message.verify(signature, message.domain, message.issued_at, message.nonce)
      session[:address] = message.address
      session[:chain_id] = message.chain_id

      render json: { ok: true }
    else
      render json: { ok: false }
    end
  end
end

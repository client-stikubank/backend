# frozen_string_literal: true

module Admin
  class QrCluesController < AdminController
    before_action :set_qr_clue, only: %i[show update destroy]

    def index
      qr_clues = QrClueService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @qr_clues = qr_clues.success
      serialize!(QrClue, @qr_clues, paginate(@qr_clues))
    end

    def create
      qr_clue = QrClueService::Create.new(params: qr_clue_params).call

      qr_clue.instance_of?(QrClue) ? serialize!(QrClue, qr_clue) : error!(qr_clue.failure[1])
    end

    def update
      qr_clue = QrClueService::Update.new(params: qr_clue_params, record: @qr_clue).call

      qr_clue.instance_of?(QrClue) ? serialize!(QrClue, qr_clue) : error!(qr_clue.failure[1])
    end

    def show
      @qr_clue ? serialize!(QrClue, @qr_clue) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      qr_clue = QrClueService::Destroy.new(record: @qr_clue).call

      qr_clue.instance_of?(QrClue) ? destroyed! : error!(qr_clue.failure[1])
    end

    private

    def qr_clue_params
      params.require(:qr_clue).permit(:clue, :image)
    end

    def set_qr_clue
      @qr_clue = QrClue.find_by(id: params[:id])
    end
  end
end

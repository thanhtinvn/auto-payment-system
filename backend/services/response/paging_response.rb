include CommonConstant

module Response
    # WARNING: Data must be Kaminari object
    class PagingResponse < BaseResponse
        def initialize
            @data = nil
            @code = 200
            @hasError = false
        end

        def set_data(entities)
            if (entities)
                @data = {
                    list: [],
                    totalRecords: entities.total_count,
                    totalPages: entities.total_pages,
                    currentPage: entities.current_page,
                    recordsPerPage: entities.limit_value || CommonConstants::FIX_NUM::DEFAULT_RECORDS_PER_PAGE
                } if @data.blank?

                entities.map do |n|
                    @data[:list].push(n)
                end
            end
        end

        def set_custom_paging_data(data, pagnation_obj)
            if (data)
                @data = {
                    list: [],
                    totalRecords: pagnation_obj[:total_count],
                    totalPages: pagnation_obj[:total_pages],
                    currentPage: pagnation_obj[:current_page],
                    recordsPerPage: pagnation_obj[:current_per_page] || CommonConstants::FIX_NUM::DEFAULT_RECORDS_PER_PAGE
                } if @data.blank?
                @data[:list] = data
            end
        end
    end
end

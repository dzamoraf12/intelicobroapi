Pagy::DEFAULT[:max_per_page] = 100
ApiPagination.configure do |config|
  # If you have more than one gem included, you can choose a paginator.
  config.paginator = :pagy # or :will_paginate
  config.page_param = :page
  config.per_page_param = :per_page
end
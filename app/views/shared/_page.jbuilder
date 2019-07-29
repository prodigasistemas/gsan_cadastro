json.page do
  json.total        total
  json.current_page models.current_page
  json.total_pages  models.total_pages
  json.first_page    models.first_page?
  json.last_page    models.last_page? || models.out_of_range?
end if total

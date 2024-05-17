select release.name as release_name, artist.name as artist_name, release_info.date_year as release_year
from release
join release_info on release.id = release_info.release
join artist_credit on release.artist_credit = artist_credit.id
join artist_credit_name on artist_credit.id = artist_credit_name.artist_credit
join artist on artist_credit_name.artist = artist.id
join medium on release.id = medium.release
join medium_format on medium.format = medium_format.id
where medium_format.name = 'Cassette'
order by release_year desc, release_info.date_month desc, release_info.date_day desc, release_name asc, artist_name asc
limit 10;
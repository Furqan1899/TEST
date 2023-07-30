
--How many bookings, room nights where status is 1 or 2 and check-in is in February?

SELECT COUNT ( booking_id) AS num_bookings,
       SUM(room_booked) AS total_room_nights
FROM [dbo].[booking$]
WHERE status IN (1, 2) AND MONTH(checkin) IN (1, 2);


  --How many tickets were received in January?

  SELECT COUNT(*) AS num_tickets
FROM [dbo].[ticket$]
WHERE MONTH(ticket_created_at) = 1;


--Mark whether the ticket is having any problem or not.

SELECT ticket_id,
       ticket_created_at,
       hotel_id,
       ticket_category,
       ticket_sub_category,
       ticket_sub_sub_category,
       CASE
           WHEN ticket_category = 'Check-In Issues' THEN 'Yes'
           WHEN ticket_category = 'Information' AND ticket_sub_sub_category IN ('Location info', 'Booking Reschedule Info', 'Hotel Policies') THEN 'Yes'
           WHEN ticket_category = 'Booking Modification' AND ticket_sub_sub_category IN ('Change in Room Category', 'Hotel Change Request', 'Room Count Increase', 'Room Count Decrease') THEN 'Yes'
           ELSE 'No'
       END AS has_problem
FROM [dbo].[ticket$];

--How many bookings are having a check-in problem in January and February?
SELECT COUNT(b.booking_id) AS checkin_problem
FROM [dbo].[booking$] b
JOIN [dbo].[ticket$] t ON b.booking_id = t.booking_id
WHERE MONTH(b.checkin) IN (1, 2)
  AND t.ticket_category = 'Check-In Issues';



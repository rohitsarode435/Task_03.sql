SELECT * FROM public.courses
select * from students
select * from enrollments
select * from courses

--1. Retrieve all students who have an active enrollment
select s.name,s.student_id,c.course_name from students as s 
join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id 
where status='Active'

--2. Find the most enrolled courses
select c.course_name,count(e.enrollment_id) as total_student from courses c left
join enrollments e on c.course_id=e.course_id group by course_name order by 
total_student desc

--3. Find students who enrolled in at least 2 courses
select s.student_id, s.name, count(e.course_id) from students s join enrollments e on
s.student_id=e.student_id group by s.student_id,s.name having count(e.course_id)>=2
 
--4. List courses that have no students enrolled
SELECT c.course_id, c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

--5. Find enrollments with conditional labels
SELECT e.enrollment_id, s.name AS student_name, c.course_name,
       CASE 
           WHEN e.enrollment_status = 'active' THEN 'Currently Enrolled'
           WHEN e.enrollment_status = 'completed' THEN 'Course Completed'
           WHEN e.enrollment_status = 'pending' THEN 'Pending Approval'
           ELSE 'Unknown Status'
       END AS enrollment_label
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

--6. Count the number of enrollments per course
select c.course_name,count(enrollment_id) from courses as c join enrollments e on
e.course_id=c.course_id
group by course_name

--7. Get students who have never enrolled in any course
select s.student_id, s.name, count(e.course_id) from students s join enrollments e on
s.student_id=e.student_id group by s.student_id,s.name having count(e.course_id)=0

--8. Get students who have enrolled in both 'Python for Data Science' and 'sql mastery'
SELECT e.student_id, s.name, s.email
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name IN ('Python for Data Science', 'SQL Mastery')
GROUP BY e.student_id, s.name, s.email
HAVING COUNT(DISTINCT c.course_name) = 2;

--9. Get the latest enrolled students (last 5 enrollments)
select s.name from students s join enrollments e
on s.student_id=e.student_id
order by s.name desc
limit 5

--10. Count the number of students enrolled in each category of courses
SELECT c.category, COUNT(e.student_id) AS student_count
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.category;

--11. Find students who have completed at least one course
SELECT DISTINCT s.student_id, s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.status = 'Completed';

--12. Retrieve students enrolled in courses under 'Programming' category
SELECT e.student_id, s.name, s.email,c.category
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.category ='Programming'
GROUP BY e.student_id, s.name, s.email,c.category

--13. Get the total number of enrollments per month
SELECT TO_CHAR(enrolled_on, 'YYYY-MM') AS month, COUNT(*) AS total_enrollments
FROM Enrollments
GROUP BY month
ORDER BY month;

--14. Find students who enrolled but never completed a course
SELECT DISTINCT s.student_id, s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Enrollments e2 ON s.student_id = e2.student_id AND e2.status = 'Completed'
WHERE e2.student_id IS NULL;

--15. Get the earliest and latest enrollment date
SELECT 
    MIN(enrolled_on) AS earliest_enrollment,
    MAX(enrolled_on) AS latest_enrollment
FROM Enrollments;

--16. Get students who enrolled in the last 6 months
select s.name,e.enrolled_on from students s join enrollments as e on e.student_id=s.student_id
where enrolled_on>= current_date - interval '6month'

--17. Find courses with more than 5 enrollments
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrollments
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) > 5;

--18. Get students and their most recent enrollment date
SELECT s.student_id, s.name, MAX(e.enrolled_on) AS most_recent_enrollment
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name
ORDER BY most_recent_enrollment DESC;

--19. Find students who enrolled but dropped a course
select s.name,s.student_id,c.course_name from students as s 
join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id 
where status='Dropped'

--20. List courses with the highest number of enrollments
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrollments
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrollments  DESC
LIMIT 1;



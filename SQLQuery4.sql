-- Query for Poki project

-- 1. What grades are stored in the database?
select Name
	from Grade

-- 2. What emotions may be associated with a poem?
select Name	
	from Emotion

-- 3. How many poems are in the database?
select count(p.id) as NumberOfPoems
	from Poem p

-- 4. Sort authors alphabetically by name. What are the names of teh top 76 authors?
select Name
	from Author

-- 5. Starting with the above query, add the grade of each of the authors
select a.Name, g.name as Grade
	from Author a
	left join Grade g on a.GradeId = g.Id

-- 6. Starting with the above query, add the recorded gener of each of the authors
select a.Name, gr.name as Grade, ge.name as Gender
	from Author a
	left join Grade gr on a.GradeId = gr.Id
	left join Gender ge on a.GenderId = ge.id

-- 7. What is the total number of words in all poems in the database?
select SUM(WordCount) as TotalWordCount
	from Poem


-- 8. Which poem has the fewest characters?
select min(p.CharCount) FewestCharNum
	from Poem p

-- 9. How many authors are in the third grade?
select count(au.id) as Grade3AuthorNum
	from Author au
	where au.GradeId = 3;

-- 10. How many authors are in the first, second, or third grades?
select count(au.id) as Grades123AuthorNum
	from Author au
	where au.GradeId = 3 or au.GradeId = 2 or au.GradeId = 1;

-- 11. What is the total number of poems written by fourth graders?
select count(p.id) as FourthGradePoems
	from Poem p
	left join Author a on p.AuthorId = a.Id
	where a.GradeId = 4;

-- 12. How many poems are there per grade?
 
select gr.id as Grade, count(p1.id) as NumPoems from Poem p1 
	left join Author a on p1.AuthorId = a.Id 
	left join Grade gr on a.GradeId = gr.Id 
		group by gr.Id
		order by gr.Id
	

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select gr.id as Grade, count(au.id) as Authors
	from Author au
	left join Grade gr on au.GradeId = gr.Id
	group by gr.id
	order by gr.id

-- 14. What is the title of the poem that has the most words?
select p.Title as LongestPoem, p.WordCount
	from Poem p
	where p.WordCount = (select max(p.WordCount) from Poem p);

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
select top 5 a.Name, count(p.id) as NumberOfPoems
	from Author a
	left join Poem p on a.Id = p.AuthorId
	group by a.id, a.Name
	order by count(p.id) DESC

-- 16. How many poems have an emotion of sadness?
select count(p.id) as SadPoems
	from Poem p
	left join PoemEmotion pe on p.Id = pe.PoemId
	left join Emotion e on pe.EmotionId = e.Id
	where e.id = 3;

-- 17. How many poems are not associated with any emotion?
select count(p.id) as EmotionlessPoems
	from Poem p
	left join PoemEmotion pe on p.Id = pe.PoemId
	left join Emotion e on pe.EmotionId = e.Id
	where e.id is NULL;

-- 18. Which emotion is associated with the least number of poems?
select top 1  em.Name, count(p.id) as NumPoems
	from Poem p
	left join PoemEmotion pe on p.Id = pe.PoemId
	left join Emotion em on pe.EmotionId = em.Id
	where em.Name is Not Null
	group by (em.Name)
	
-- 19. Which grade has the largest number of poems with an emotion of joy?
select top 1 gr.Name, count(e.id) as JoyEmotion
	from Grade gr
	left join Author a on gr.id = a.GradeId
	left join Poem p on a.id = p.AuthorId
	left join PoemEmotion pe on p.id = pe.PoemId
	left join Emotion e on e.id = pe.EmotionId
	where e.Id = 4
	group by gr.Name 
	order by count(e.id) DESC

-- 20. Which gender has the least number of poems with an emotion of fear?
select top 1 gen.Name, count(e.id) as FearEmotion
	from Gender gen
	left join Author a on gen.id = a.GenderId
	left join Poem p on a.id = p.AuthorId
	left join PoemEmotion pe on p.id = pe.PoemId
	left join Emotion e on e.id = pe.EmotionId
	where e.id = 2
	group by gen.Name 
	order by count(e.id) DESC

-- 1) Retrieve universities with an academic reputation score greater than a 95 value.

SELECT *
FROM dbo.Top100Uni
WHERE academic_reputation > 95

 --2) Calculate the average overall score for all universities.

SELECT AVG(overall_score) AS AverageOverallScore
FROM dbo.Top100Uni;

-- 3) Rank universities based on their international students ratio.

SELECT rank,
       university,
       international_students_ratio
FROM dbo.Top100Uni
ORDER BY international_students_ratio DESC;

-- 4) Retrieve universities with an employer reputation score above 90.

SELECT *
FROM dbo.Top100Uni
WHERE employer_reputation > 90;

-- 5) Display the overall score and academic reputation for the top 10 universities.

SELECT TOP 10
       RANK,
       university,
       overall_score,
       academic_reputation
FROM dbo.Top100Uni
ORDER BY overall_score DESC;

-- 6) retrieves the top 5 universities with the highest international student ratios.

SELECT TOP 5
    rank,
    university,
    international_students_ratio
FROM
    dbo.Top100Uni
ORDER BY
    international_students_ratio DESC;

-- 7)  identifies the university with the highest employer reputation, including its rank and name.

SELECT
    Rank,
    university,
    employer_reputation
FROM
    dbo.Top100Uni
WHERE
    employer_reputation = (SELECT MAX(employer_reputation) FROM dbo.Top100Uni);


-- 8) Use a Common Table Expression to find the top 3 universities based on citations per faculty.

WITH TopCitationsCTE AS (
    SELECT rank,
           university,
           citations_per_faculty,
           ROW_NUMBER() OVER (ORDER BY citations_per_faculty DESC) AS RankByCitations
    FROM dbo.Top100Uni
)
SELECT *
FROM TopCitationsCTE
WHERE RankByCitations <= 3;

-- 9) Identify universities with an academic reputation higher than the overall average academic reputation.

SELECT *
FROM dbo.Top100Uni
WHERE academic_reputation > (SELECT AVG(academic_reputation) FROM dbo.Top100Uni);

 --10) Use the CASE statement to categorize universities into different groups based on their overall score.

SELECT university,
       overall_score,
       CASE
           WHEN overall_score >= 95 THEN 'Excellent'
           WHEN overall_score >= 80 AND overall_score < 95 THEN 'Very Good'
           ELSE 'Good'
       END AS ScoreCategory
FROM dbo.Top100Uni;

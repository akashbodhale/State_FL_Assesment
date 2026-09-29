-- here logic is 1st slecting providers name, speciality and applications appplicationId count by count function 
-- as  we want all the record from provider table we are applying left join so every record will be there of providers table and then right side applicationsIds count  
-- which has in rage of date today to last 90 days.
--  as we are using count aggreate function then Group by combine result to 1 row. i.e with out it providers coloumn get dublicated and count can not be used.
-- and last with desending order of count of applicationId we are showing result.

SELECT
    Providers.Name,
    Providers.Specialty,
    COUNT(Applications.ApplicationId) AS ApplicationCount
FROM Providers
LEFT JOIN Applications
    ON Providers.ProviderId = Applications.ProviderId
    AND Applications.SubmittedDate >= DATEADD(DAY, -90, GETDATE())
GROUP BY
    Providers.ProviderId,
    Providers.Name,
    Providers.Specialty
ORDER BY
    COUNT(Applications.ApplicationId) DESC;

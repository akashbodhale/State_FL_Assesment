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

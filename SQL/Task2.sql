CREATE TABLE ApplicationStatusAudit
(
    AuditId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT,
    OldStatus NVARCHAR(50),
    NewStatus NVARCHAR(50),
    ChangedDate DATETIME
);
GO

CREATE PROCEDURE UpdateApplicationStatus
    @ApplicationId INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN

    DECLARE @OldStatus NVARCHAR(50);

    BEGIN TRY

        IF @ApplicationId IS NULL OR @NewStatus IS NULL
        BEGIN
            PRINT 'Invalid input';
            RETURN;
        END

        SELECT @OldStatus = Status
        FROM Applications
        WHERE ApplicationId = @ApplicationId;

        IF @OldStatus IS NULL
        BEGIN
            PRINT 'Application not found';
            RETURN;
        END

        UPDATE Applications
        SET Status = @NewStatus
        WHERE ApplicationId = @ApplicationId;

        INSERT INTO ApplicationStatusAudit
        VALUES
        (
            @ApplicationId,
            @OldStatus,
            @NewStatus,
            GETDATE()
        );

        PRINT 'Status updated successfully';

    END TRY

    BEGIN CATCH
        PRINT 'Error while updating status';
    END CATCH

END;
GO

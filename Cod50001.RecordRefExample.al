codeunit 50001 "RecordRefExample"
{
    procedure PreventDataDeletionIfUsed2(RecRef: RecordRef)
    var
        Field: Record Field;
        RecRef2: RecordRef;
        DataUsedLbl: Label 'The value %1 exists in the field %2 of %3 table. Deletion is not allowed.';
    begin
        //FIXME
        Field.Get(RecRef.Number, RecRef.KeyIndex(1).FieldIndex(1).Number);
        //FIXME
        Field.SetRange(Type, Field.Type);
        Field.SetRange(RelationTableNo, RecRef.Number);
        Field.SetRange(ObsoleteState, Field.ObsoleteState::No);
        if Field.FindSet(false) then begin
            repeat
                RecRef2.Open(Field.TableNo);
                RecRef2.Field(Field."No.").SetRange(RecRef.KeyIndex(1).FieldIndex(1).Value);
                if not RecRef2.IsEmpty then begin
                    Error(DataUsedLbl, RecRef.KeyIndex(1).FieldIndex(1).Value, Field."Field Caption", RecRef2.Caption);
                end;
                RecRef2.Close();
            until Field.Next() = 0;
        end;
    end;
}

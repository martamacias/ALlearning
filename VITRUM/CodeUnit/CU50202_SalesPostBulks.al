codeunit 50202 SalesPostBulks
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', true, true)]
    local procedure saveShipmentNo(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        bulks: Record "Shipment Bulks";
    begin
        if SalesShipmentHeader."No." <> '' then begin
            bulks.Init();
            bulks.SetFilter("Order No.", SalesHeader."No.");
            if bulks.FindSet() then
                repeat
                    bulks."Shipment No." := SalesShipmentHeader."No.";
                    bulks.Modify(true);
                until bulks.Next() = 0;
        end;
    end;
}
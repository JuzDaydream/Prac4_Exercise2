<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrder.aspx.cs" Inherits="Prac4_Exercise2.SalesOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 46px;
        }

        .auto-style2 {
            width: 266px;
        }

        .auto-style3 {
            width: 266px;
            height: 80px;
        }

        .auto-style4 {
            height: 80px;
        }

        .auto-style5 {
            width: 266px;
            height: 30px;
        }

        .auto-style6 {
            height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style1" colspan="2" style="font-weight: bold; font-size: 20px;">Sales Order Information By Staff</td>
                </tr>
                <tr>
                    <td class="auto-style2">Please Select Staff Name:</td>
                    <td>Please Select Year:</td>
                </tr>
                <tr>
                    <td class="auto-style3" style="vertical-align: top">
                        <asp:DropDownList ID="ddlStaff" runat="server" DataSourceID="sdsStaff" DataTextField="Name" DataValueField="EmployeeID" Height="24px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style4" style="vertical-align: top;">
                        <asp:RadioButtonList ID="rblYear" runat="server" DataSourceID="sdsYear" DataTextField="Year" DataValueField="Year">
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5"></td>
                    <td class="auto-style6">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style6">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style6" colspan="2">
                        <asp:Label ID="lblTitleGridView" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5" style="vertical-align: top">
                        <asp:GridView ID="gvOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="OrderID" DataSourceID="sdsOrderDate" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                                <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" DataFormatString="{0:dd MMMM yyyy}" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#242121" />
                        </asp:GridView>
                    </td>
                    <td class="auto-style6" style="vertical-align: top">
                        <asp:Label ID="lblOldSales" runat="server"></asp:Label>
                        <asp:DataList ID="dlOrderDetails" runat="server" DataKeyField="OrderID" DataSourceID="sdsOrderDetails" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <ItemTemplate>
                                Product Name:
                                <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
                                <br />
                                UnitPrice:
                                <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice","{0:0.00}") %>' />
                                <br />
                                Quantity:
                                <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                                <br />
                                Discount:
                                <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount") %>' />%
                                <br />
                                Sales:
                                $<asp:Label ID="SalesLabel" runat="server" Text='<%# Eval("TotalPrice","{0:0.00}") %>' />
                                <br />
                                <br />

                            </ItemTemplate>

                            <SelectedItemStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />

                        </asp:DataList>
                    </td>
                </tr>
            </table>
        </div>
        <p>
            <asp:SqlDataSource ID="sdsStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT (LastName, CONCAT(' ',FirstName)) AS Name, EmployeeID
FROM Employees
"></asp:SqlDataSource>
        </p>
        <p>
            <asp:SqlDataSource ID="sdsYear" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT YEAR(OrderDate) AS Year FROM Orders WHERE Orders.EmployeeID=@EmployeeID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlStaff" Name="EmployeeID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsOrderDate" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [OrderID], [OrderDate] FROM [Orders] WHERE ((YEAR([OrderDate]) = YEAR(@OrderDate)) AND ([EmployeeID] = @EmployeeID))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="rblYear" Name="OrderDate" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddlStaff" Name="EmployeeID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsOrderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, ([Order Details].Discount*100) As Discount, Products.ProductName, 
Round(([Order Details].UnitPrice*(1-[Order Details].Discount) * [Order Details].Quantity ),2) AS TotalPrice
FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID WHERE ([Order Details].OrderID = @OrderID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvOrder" Name="OrderID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </form>
</body>
</html>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookInventory.aspx.cs" Inherits="Library.BookInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        function btnClicked() {
            $(document).click(function (event) {
                var book_title = $(event.target).text();
                console.log(book_title);
                var url = new URLSearchParams(window.location.search);
                url.set('title', book_title);
                var newUrl = "BookDescription.aspx?" + url.toString();
                window.location.href = newUrl;
            });
        }
    </script>


    <section>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <img src="Images/writer.png" width="100px" />
                                    <h5>Book Inventory</h5>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col-md-6">

                                    <div class="form-group">
                                        <input type="text" class="form-control mb-1" id="TextBox1" placeholder="Member Id" />
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="form-group">
                                        <asp:Button ID="Button1" CssClass="btn btn-primary " runat="server" Text="Fetch Details" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Button ID="Button3" CssClass="btn btn-danger " runat="server" Text="Upload" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <h4>Books List</h4>
                                    <hr />
                                </center>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-1">
                                            1.
                                        </div>
                                        <div class="col-md-11">
                                            <h5 onclick="btnClicked()" class="bookTitle">The Power of Subconcious Mind
                                            </h5>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1">
                                            2.
                                        </div>
                                        <div class="col-md-11">
                                            <h5 onclick="btnClicked()" class="bookTitle">Once Upon A Time in Hollywood
                                            </h5>
                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

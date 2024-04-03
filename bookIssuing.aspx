<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bookIssuing.aspx.cs" Inherits="Library.bookIssuing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "WebServices/bookIssue.asmx/getIssuedBookServ",
                contentType: "application/json",
                success: function (res) {
                    var jsonData = res.d;
                    console.log(res);
                    $("#tbl_data").bootstrapTable({
                        cache: true,
                        pagination: true,
                        striped: true,
                        pageSize: 10,
                        data: jsonData,
                        columns: [
                            {
                                field: 'memberName',
                                title: 'Member Name'
                            },
                            {
                                field: 'bookName',
                                title: 'Book Name'
                            },
                            {
                                field: 'issue_date',
                                title: 'Issue Date'
                            },
                            {
                                field: 'due_date',
                                title: 'Due Date'
                            },
                        ]
                    });
                },
                error: function (err) {
                    if (err.responseJSON && err.responseJSON.message) {
                        alert(err.responseJSON.message);
                    } else if (err.responseText) {
                        alert(err.responseText);
                    } else {
                        alert("An error occurred");
                    }
                }
            });
        });

        function btnGo() {
            var memId = $("#txtMemId").val();
            var bookId = $("#txtBookId").val();
            
            var objData = JSON.stringify(Jsondata);

            $.ajax({
                type: 'POST',
                url: 'WebServices/bookIssue.asmx/validateDetails',
                contentType: 'application/json',
                data: JSON.stringify({ 'memId': memId, 'bookId': bookId }),
                success: function (res) {
                    console.log(res);
                },
                error: function (err) {
                    if (err.responseJSON && err.responseJSON.message) {
                        alert(err.responseJSON.message);
                    } else if (err.responseText) {
                        alert(err.responseText);
                    } else {
                        alert("An error occurred");
                    }
                }
            })
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
                                    <img src="Images/books.png" width="100px" />
                                    <h5>Book Issuing</h5>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Member Id</label>
                                    <div class="form-group">
                                        <input type="text" class="form-control mb-1" id="txtMemId" placeholder="Member Id"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>Book Id</label>
                                    <div class="row">
                                        <div class="col-md-10">
                                            <div class="form-group">
                                                <input type="text" class="form-control mb-1" id="txtBookId" placeholder="Book Id"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="button" class="btn btn-primary" value="Go" onclick="btnGo()" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Member Name</label>
                                    <div class="form-group">
                                        <input type="text" class="form-control mb-1" id="txtMemName" disabled placeholder="Member Name"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>Book Name</label>
                                    <div class="form-group">
                                        <input type="text" class="form-control mb-1" id="txtBookName" disabled placeholder="Book Name"/>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Start Date</label>
                                    <div class="form-group">
                                       <input type="date" class="form-control mb-1" id="txtIssueDate"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>End Date</label>
                                    <div class="form-group">
                                        <input type="date" class="form-control mb-1" id="txtDueDate"/>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="d-grid gap-2">
                                        <input type="button" class="btn btn-danger" id="btnIssue" value="Issue Book" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-grid gap-2">
                                        <input type="button" class="btn btn-success" id="btnReturn" value="Issue Book" />
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
                                    <h4>Issued Books List</h4>
                                    <hr />
                                </center>
                            </div>
                            <div class="row">
                                <table class="table table-striped" id="tbl_data">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

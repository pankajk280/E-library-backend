<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bookIssueDues.aspx.cs" Inherits="Library.bookIssueDues" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>

        $(document).ready(function () {
            $.ajax({
                type: 'POST',
                url: "WebServices/bookIssue.asmx/GetDefaulters",
                contentType: "application/json",
                success: function (res) {


                    var jsondata = res.d;
                    $("#tbl_data").bootstrapTable({
                        cache: true,
                        data: jsondata,
                        striped: true,
                        pagination: true,
                        pageSize: 10,
                        columns: [
                            {
                                field: 'state',
                                checkbox: true,
                                align: 'center',
                                valign:'middle'

                            },

                            {
                                field: 'member_name',
                                title: 'Member Name',
                                
                            },
                            {
                                field: 'book_name',
                                title: 'Book Name',
                            },
                            {
                                field: 'Email',
                                title: 'Email ID',
                            },
                            {
                                field: 'totalDays',
                                title: 'Total Due Days',
                            },
                            {
                                field: 'fine',
                                title: 'Total Fine',
                                
                            },
                            {
                                field: 'operate',
                                title: 'Item Operate',
                                align: 'center',
                                clickToSelect: false,
                                events: window.operateEvents,
                                formatter: operateFormatter
                                
                            }
                        ],


                    });
                },
                error: function (err) {
                    console.log(err);
                }

            });
        });
        function operateFormatter(value, row, index) {
            return [
                '<a class="remove" href="javascript:void(0)" title="Remove">'+
                '<i class="fa fa-trash"></i>'+
                '</a>'
            ]
        }
        window.operateEvents = {
            'click .remove': function (e, value, row, index) {

                var memberEmail = row.Email;
                $.ajax({
                    type: 'POST',
                    url: "WebServices/bookIssue.asmx/DeleteDefaulters",
                    contentType: "application/json",
                    data: JSON.stringify({ 'defaultersEmail': memberEmail }),
                    success: function (res) {
                        alert(res.d);
                        $("#tbl_data").bootstrapTable('remove', {
                            field: 'member_name',
                            values: [row.member_name]
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


                
            }
        }

        function getSelectedEmails() {
            return $.map($("#tbl_data").bootstrapTable('getSelections'), function (row) {
                return {email: row.Email,fine:row. fine} ;
            })
        }

        function btn_sendMail() {

            var Email_fines = getSelectedEmails();
            if (Email_fines.length > 0) {
                var jsonEmail = JSON.stringify(Email_fines);
                $.ajax({
                    type: 'POST',
                    url: "WebServices/bookIssue.asmx/mailService",
                    contentType: "application/json",
                    data: JSON.stringify({ 'objEmail': jsonEmail }),
                    success: function (res) {
                        if (res.d == "Success") {
                            alert("Mail sent Successfully");
                        }

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
            }
           
            
        }

    </script>


    <section>
        <div class="container">
            <div class="row">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-10">
                                <h3 class="text-danger">Defaulters Details</h3>
                                <br />
                                <table class="table table-striped" id="tbl_data">
                                </table>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-danger mx-auto" onclick="btn_sendMail(); return false;">Send Email</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</asp:Content>

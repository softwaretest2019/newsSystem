
function update(address,id)
{
    window.location.href = address+"/systemServlet?flag=update&id="+id;
}

function deletex(address,id)
{
    if(confirm('确实要删除该条博客吗?')) {
        window.location.href = address + "/systemServlet?flag=delete&id=" + id;
    }
}
function addNewBlog(address) {
    window.location.href = address + "/addBlog.jsp";
}
function mangerBlog(address) {
    window.location.href = address + "/systemServlet?flag=manger&pageNum=1";
}
function getDetail(address,id){
    window.location.href = address + "systemServlet?flag=checkDetail&id="+id;
}

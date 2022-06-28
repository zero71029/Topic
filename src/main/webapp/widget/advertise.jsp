<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div class="advertise">
        <el-carousel trigger="click" height="500px">
            <el-carousel-item v-for="( s, index) in advertise" :key="index" :interval="5000">
                <a :href="s.url" target="_blank"><img :src="'${pageContext.request.contextPath}/file/'+s.img" :alt="s.name"></a>                
            </el-carousel-item>
        </el-carousel>
    </div>

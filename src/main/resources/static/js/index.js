var vm=new Vue({el:".app",data(){return{popular:[],news:[],sensor:[],apparatus:[],Netcom:[],software:[],controlbox:[],application:[],rigthAdvertise:[],middleAdvertise:[],}},created(){$.ajax({url:contextPath+'/init',type:'POST',async:false,cache:false,success:response=>{this.popular=response.popular;this.news=response.news;this.sensor=response.sensor;this.apparatus=response.apparatus;this.Netcom=response.Netcom;this.software=response.software;this.controlbox=response.controlbox;this.application=response.application;this.news.forEach(e=>{this.changGrop(e)});this.popular.forEach(e=>{this.changGrop(e)});this.sensor.forEach(e=>{this.changGrop(e)});this.apparatus.forEach(e=>{this.changGrop(e)});this.Netcom.forEach(e=>{this.changGrop(e)});this.software.forEach(e=>{this.changGrop(e)});this.controlbox.forEach(e=>{this.changGrop(e)});this.application.forEach(e=>{this.changGrop(e)})},error:function(returndata){console.log(returndata)}});$.ajax({url:contextPath+'/topic/advertiseinit?location=右',type:'get',async:false,cache:false,success:response=>{this.rigthAdvertise=response},error:function(returndata){console.log(returndata)}});$.ajax({url:contextPath+'/topic/advertiseinit?location=中',type:'get',async:false,cache:false,success:response=>{this.middleAdvertise=response},error:function(returndata){console.log(returndata)}})},methods:{changGrop(e){switch(e.articlegroup){case'sensor':e.group="感測器";break;case'apparatus':e.group="儀器儀表";break;case'Netcom':e.group="網通裝置";break;case'software':e.group="軟體配件";break;case'controlbox':e.group="控制箱";break;case'application':e.group="應用";break;case'system':e.group="系統";break}},},})
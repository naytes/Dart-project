import 'dart:html';
import 'dart:math';
import 'dart:async';
//import 'dart:io';
CanvasElement canvas;
CanvasRenderingContext2D ctx;


var bounce;

class Ball {
  var rad = 20.0; //made the ball a little bigger
  var x = 50.0;
  var y = 50.0;
  var horVeloc = 0.0;
  var verVeloc = 0.0;
}



void main(){
  bounce = new Ball();
  canvas = querySelector('#canvas');
  ctx = canvas.getContext('2d');
  drawBall();
  ctx.canvas.onClick.listen(resetOnClick);
}

void resetOnClick(MouseEvent e){
  
  //check to make sure click doesnt put part of the ball outside of the box
  if(e.offset.x < canvas.width - bounce.rad && e.offset.y < canvas.height - bounce.rad){ 
  	bounce.x = e.offset.x;
  	bounce.y = e.offset.y;
  	bounce.horVeloc = 0.0;
  	bounce.verVeloc = 0.0;
  }
  
}



void drawBall(){
  ctx.clearRect(0,0, canvas.width, canvas.height);
  bounce.x = bounce.x + bounce.horVeloc;
  bounce.y = bounce.y + bounce.verVeloc;
  
  //changed these values from the javascript values to make the ball bounce more similarly to the embedded example
  bounce.horVeloc = bounce.horVeloc * .996;
  bounce.verVeloc = bounce.verVeloc * .996;
  bounce.horVeloc = bounce.horVeloc + .07;
  bounce.verVeloc = bounce.verVeloc + .07;
  ctx.save();
  ctx.translate(bounce.x, bounce.y);
  ctx.fillStyle = "salmon"; //salmon is a cool coolor
  ctx.beginPath();
  ctx.arc(0, 0, bounce.rad, 0, pi*2, false);
  ctx.closePath();
  ctx.fill();
  ctx.restore();
  
  
  if(bounce.x + bounce.rad > canvas.width){
    bounce.x = canvas.width - bounce.rad;
    bounce.horVeloc = (-1) * bounce.horVeloc;   
    }
  if (bounce.y + bounce.rad > canvas.height){
    bounce.y = canvas.height - bounce.rad;
    bounce.verVeloc = (-1) * bounce.verVeloc;
  }
  timeWait();
}

const timeout = const Duration(seconds: 0);
const ms = const Duration(milliseconds: 1);

timeWait([int milliseconds]) {
  var duration = milliseconds == null ? timeout : ms * milliseconds;
  return new Timer(duration, drawBall);
}

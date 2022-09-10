# OpenGL series

## 1. VertexBuffer
## 2. IndexBuffer
## 3. Shader
## 4. Reneder
## 5. Texture
## 6. Blender
## 7. Projection
1.  Orthogonality projection 
	- 正交投影
	- Usually 2D
 2. Perspective projection
	 - 透视投影
	 - Usually 3D
- MVP : model view projection
` m * v * p`
- ImGui: translation

## 8. How to draw a graph twice?
1. Add one more `translation`
![](attachments/Pasted%20image%2020220817173642.png)
2. Add one more `model`, and use <u>same</u> `shader` ( so don't need double BIND)
![](attachments/Pasted%20image%2020220817174257.png)
3. Option: add slider bar to control. by `ImGui`
![](attachments/Pasted%20image%2020220817174403.png)


---
## 9. Create a test frame

1. Create a Test class as <label style="color: red;" > Fundamental Class</label> contains virtual function:  `OnUpdate`,  `OnRender`,  `OnImGuiRender`.
![](attachments/Pasted%20image%2020220819045852.png)
Let son class to inherited.

---
2.  Create a `TestMenu` class as a entry point for all test class.
	- Maintain a `vector` to contain **Test Method Label** and **Test Function's pointer**;
	- Maintain a `Test Ptr` to specific  active current running test;
	- A template func to add test method;
	- Implement `OnImGuiRender`  to render the **Test Control Frame**;
	![](attachments/Pasted%20image%2020220819050718.png)
	
---
3. `OnImGuiRender` : Traverse this vector and do for every individual:
	1. Show str label of it as a `Button` on `TestMenu` frame, and check whether clicked.
	2. If clicked, change the `m_CurrentTest` by ptr to ptr (二级指针)
	3. Then the program will run the new test method
	![](attachments/Pasted%20image%2020220819051711.png)
	
---
4. In main func initialize a nullptr as `currentTest` as default `m_CurrentTest` of `TestMenu`, and register the Tests that **has inherited** `Test` class.
![](attachments/Pasted%20image%2020220819052151.png)
	
---
5. In main loop to check `currentTest` and render it
![](attachments/Pasted%20image%2020220819052316.png)
	- If `currentTest==testMenu` , the `Button`  of  `<-`  will not be render.
	- In `OnImGuiRender` to change `currentTest` ptr.
	- Delete `currentTest` and `testMenu` ptr when ending main loop

---

## 10. More effective uniform
![](attachments/Pasted%20image%2020220819214001.png)
Use cache to store `location`, and reduce multiply call `glGetUniformLocation` func.

---
## 11. Batch render


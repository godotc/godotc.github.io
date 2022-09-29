- VKRenderPass

![](attachments/1113490-20170612104658415-904586548.jpg)

>**initialLayout**指定图像在开始进入渲染通道render pass前将要使用的布局结构。**finalLayout**指定当渲染通道结束自动变换时使用的布局。使用**VK_IMAGE_LAYOUT_UNDEFINED**设置**initialLayout**，意为不关心图像之前的布局。特殊值表明图像的内容不确定会被保留，但是这并不总要，因为无论如何我们都要清理它。我们希望图像渲染完毕后使用交换链进行呈现，这就解释了为什么**finalLayout**要设置为**VK_IMAGE_LAYOUT_PRESENT_SRC_KHR**。

![](attachments/1113490-20170612114241946-470130568.jpg)
- 线性的layout 与 optimal/tiled (平铺) 最佳的内存布局
- 显存里的 optimal memory layout 从内存里 linear layout 读写储存格式优化而来
- GPU 更多地 支持 tiled （平铺）布局 或 optimal（最佳） 布局 来降低 gpu 处理数据开销
<script setup>
import { computed, onMounted, ref } from "vue";
import { createToken } from "../../api/autoIdempotent.js";
import { testSaveMyorder } from "../../api/testmyorder.js";
const formToken = ref("")
const saveTip = ref("")
const proName = ref("")
const proPrice = ref(0)
const proNumber = ref(1)
const orderPrice = computed(() => proPrice.value * proNumber.value)


onMounted(() => {
  createFormToken()
})

async function createFormToken() {
  //先请求后端，生成token , 一份放在 vue页面 , 一份放在Redis
  const response = await createToken()
  console.log(response)
  formToken.value = response.data.data
  console.log("formToken = " + formToken.value)
}

async function saveFormOrder() {
  const testMyOrder = {
    formToken: formToken.value,
    proName: proName.value,
    proPrice: proPrice.value,
    proNumber: proNumber.value,
    orderPrice: orderPrice.value
  }

  console.log("saveOrder token = " + formToken.value)
  console.log(testMyOrder)
  const response = await testSaveMyorder(testMyOrder)
  if (response.data.code === 200) {
    saveTip.value = "下订单成功"
  } else {
    saveTip.value = "下订单失败"
  }
}
</script>

<template>

  <div>
    <h1>下订单</h1>

    <span>{{ saveTip }}</span>
    <input type="hidden" name="formToken" v-model="formToken" /> {{ formToken }}
    商品名称：<input type="text" v-model="proName" /> {{ proName }} <br>
    商品价格：<input type="text" v-model="proPrice" /> {{ proPrice }} <br>
    商品数量：<input type="text" v-model="proNumber" /> {{ proNumber }} <br>
    订单价格：<input type="text" v-model="orderPrice" /> {{ orderPrice }} <br>
    <button @click="saveFormOrder">下订单</button>

  </div>
</template>

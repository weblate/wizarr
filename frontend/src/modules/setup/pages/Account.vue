<template>
    <div>
        <h1 class="text-xl text-center font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
            {{ __("Admin Account") }}
        </h1>
        <FormKit type="form" v-model="accountForm" @submit="createAccount" submit-label="Create Account" :submit-attrs="{ wrapperClass: 'flex justify-end' }">
            <!-- Display Name -->
            <FormKit type="text" label="Display Name" name="display_name" placeholder="Marvin Brown" validation="alpha_spaces:latin" required autocomplete="name" />

            <!-- Username -->
            <FormKit type="text" label="Username" name="username" placeholder="marvin" validation="alpha:latin|lowercase" required autocomplete="username" :restrictions="{ alpha_numeric: true }" />

            <!-- Email -->
            <FormKit type="email" label="Email" name="email" placeholder="marvin@wizarr.dev" validation="email" required autocomplete="email" />

            <!-- Password -->
            <FormKit type="password" label="Password" name="password" placeholder="••••••••" required autocomplete="new-password" />
            <PasswordMeter :password="accountForm.password" class="mb-[23px] mt-1 px-[2px]" v-if="accountForm.password" />

            <!-- Confirm Password -->
            <FormKit type="password" label="Confirm Password" name="confirm_password" placeholder="••••••••" required autocomplete="new-password" />
        </FormKit>
    </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

import DefaultInput from "@/components/Inputs/DefaultInput.vue";
import DefaultButton from "@/components/Buttons/DefaultButton.vue";
import DefaultToast from "@/components/Toasts/DefaultToast.vue";

import PasswordMeter from "vue-simple-password-meter";

export default defineComponent({
    name: "AdminAccount",
    components: {
        DefaultInput,
        DefaultButton,
        PasswordMeter,
    },
    data() {
        return {
            buttonLoading: false,
            accountForm: {
                display_name: "",
                username: "",
                email: "",
                password: "",
                confirm_password: "",
            },
        };
    },
    methods: {
        async createAccount() {
            // Start button loading animation and get target
            this.buttonLoading = true;

            // If the passwords do not match, display an error
            if (this.accountForm.password != this.accountForm.confirm_password) {
                this.$toast.error("Passwords do not match");
                this.buttonLoading = false;
                return;
            }

            // Convert json to form data
            const formData = new FormData();

            Object.entries(this.accountForm).forEach(([key, value]) => {
                formData.append(key, value);
            });

            // Send request to API to create admin account
            await this.$axios.post("/api/setup/accounts", formData).catch(() => {
                // Stop button loading animation
                this.buttonLoading = false;

                // Display an error message
                this.$toast.error(DefaultToast("Account Error", "Failed to create admin account"));

                // Throw the error
                throw new Error("Failed to create admin account");
            });

            // Show a success message
            this.$toast.info("The admin account has been created");

            // Go to next step
            this.$emit("nextStep");
        },
    },
});
</script>

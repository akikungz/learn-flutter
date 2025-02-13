import z from 'zod';

const envSchema = z.object({
    PORT: z.string().default('3000'),
    NODE_ENV: z.string().default('development'),
    DATABASE_URL: z.string().default(''),
});

export type Env = z.infer<typeof envSchema>;

export const env: Env = envSchema.parse(process.env);